const express = require('express');
const router = express.Router();
const dbConfig = require('../../core/db');
const mysql = require('mysql');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const firebaseSecurity = require('firebase-scrypt');




const parameters = {
    memCost: 14,
    rounds: 8,
    saltSeparator: 'Bw==',
    signerKey: 'IbuhlHCi1htxQKG5bQlTBa8FgceAnnZCBGdkZeTQUKtKPmGcuQkhpqinJe+NIGrFuXeq5rNduMdU4wPdJxTZ4g==',
}

const scrypt = new firebaseSecurity.FirebaseScrypt(parameters)

router.post('/signup', async(req, res) => {
    var conn = mysql.createConnection(dbConfig);
    if (req.body.email != null && req.body.password != null) {
        var query = 'SELECT * FROM user where email = ?';
        var parameters = [req.body.email];
        conn.query(query, parameters, function(err, result) {
            if (err) {
                res.status(500).json({
                    error: {
                        message: err
                    }
                });
            }
            if (Object.keys(result).length != 0) {
                res.status(500).json({
                    error: {
                        message: 'User Already Exist'
                    }
                });

            } else {

                bcrypt.genSalt(10, (err, salt) => {
                    if (err) {
                        res.status(500).json({
                            error: {
                                message: err
                            }
                        });
                    } else {

                        scrypt.hash(req.body.password, salt)
                            .then(hash => {

                                var sql = "INSERT INTO user ( email, hash, salt) VALUES ( ?, ?, ?)";
                                var parameters = [req.body.email, hash, salt];
                                conn.query(sql, parameters, function(err, result) {
                                    if (err) {
                                        res.status(500).json({
                                            error: {
                                                message: err
                                            }
                                        });
                                    } else {
                                        res.status(201).json({
                                            message: 'Success',
                                            data: {
                                                email: req.body.email,
                                                password: hash,
                                                userId: result.insertId,
                                            }
                                        });
                                    }
                                })
                                conn.end();
                            })
                    }
                })


            }
        })
    } else {
        conn.end();
        return res.status(404).json({
            error: {
                message: 'not found'
            }
        });

    }

});

router.post('/signin', async(req, res) => {
    var conn = mysql.createConnection(dbConfig);
    if (req.body.email != null && req.body.password != null) {
        var query = 'SELECT * FROM user where email = ?';
        var parameters = [req.body.email];
        conn.query(query, parameters, function(err, result) {
            if (err) {
                return res.status(500).json({
                    error: {
                        message: err
                    }
                });
            }
            if (result.length == 0) {
                return res.status(500).json({
                    error: {
                        message: 'user not found'
                    }
                });
            } else {
                var hash = result[0].hash;
                var salt = result[0].salt;
                scrypt.verify(req.body.password, salt, hash).then(isValid => {
                    if (isValid) {
                        const token = jwt.sign({
                            email: result[0].email,
                            userId: result[0].uid,
                        }, process.env.JWT_KEY, {
                            expiresIn: '1h'
                        });
                        return res.status(200).json({
                            message: 'success',
                            userdata: result[0],
                            access_token: token,
                        });

                    } else {
                        return res.status(500).json({
                            error: {
                                message: 'Auth Failed Password mismatch'
                            }
                        });
                    }
                })
            }
        })
    } else {
        return res.status(404).json({
            error: {
                message: 'not found'
            }
        });

    }
    conn.end();
});

module.exports = router;