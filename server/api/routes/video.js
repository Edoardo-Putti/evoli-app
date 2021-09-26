const express = require('express');
const router = express.Router();
const dbConfig = require('../../core/db');
const mysql = require('mysql');

router.post('/retriveVideo', async(req, res) => {
    var conn = mysql.createConnection(dbConfig);
    if (req.body.uid != null) {
        var query = 'SELECT * FROM video where uid = ?';
        var parameters = [req.body.uid];
        conn.query(query, parameters, function(err, result) {
            if (err) {
                res.status(500).json({
                    error: {
                        message: err
                    }
                });
            } else {
                res.status(200).json({
                    data: result
                })
            }
        })
    }
})

module.exports = router;