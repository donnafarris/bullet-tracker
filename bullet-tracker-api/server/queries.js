//handlers and DB integration

const Pool = require("pg").Pool;
const pool = new Pool({
  user: "postgres",
  host: "db", //database link
  database: "bullets",
  password: "1967",
  port: 5432,
});

pool.on("error", (err, client) => {
  console.error("Unexpected error on idle client", err);
  process.exit(-1);
});

pool.connect((err, client, done) => {
  //need to set to select bullets where user id === current session user id
  if (err) throw err;
});

//getBullets ✓
//getBulletsById ✓

//get bullets by userID
//post new bullets ✓
//remove bullets
//edit bullets

const login = (req, res) => {
  let userCookie = req.body;
  let result;
  if (userCookie.userid) {
    result = { status: "success", message: "You are logged in." };
    res.cookie("UID", userCookie.userid);
  } else {
    result = {
      status: "failed",
      message: "You have not logged in. Try /login.",
    };
    res.status(404);
  }
  res.json(result);
  res.end();
};

const getBullets = (req, res) => {
  if (req.cookies.UID) {
    let UID = req.cookies.UID;
    pool.query(
      "SELECT * FROM bullets WHERE user_id = $1 ORDER BY bulletid ASC;",
      [UID],
      (error, results) => {
        if (error) {
          throw error;
        }
        res.status(200).json(results.rows);
      }
    );
  } else {
    res.send("You're not logged in.");
  }
};

const getBulletIds = (req, res) => {
  pool.query(`SELECT bulletid FROM bullets;`, (err, results) => {
    if (err) {
      res.send(err.message);
    }
    res.status(200).json(results.rows);
  });
};

const getBulletsById = (req, res) => {
  const id = parseInt(req.params.id);
  pool.query(
    "SELECT * FROM bullets WHERE bulletid = $1;",
    [id],
    (error, results) => {
      if (error) {
        throw error;
      }
      if (results.rows.length === 0) {
        res.send(`Bullet ${id} does not exist.`);
      } else {
        res.status(200).json(results.rows);
      }
    }
  );
};

const deleteBullet = (req, res) => {
  const sql = `DELETE FROM bullets
              WHERE bulletid = $1
              RETURNING *;`;
  const id = [parseInt(req.params.id)];
  pool.query(sql, id, (error, results) => {
    if (error) {
      res.send(error.message);
      return;
    } else {
      if (results) {
        res.status(200).send(`Bullet ${id} successfully deleted.`);
        console.log(results.affectedRows);
        return;
      } else {
        res.send(`Bullet ${id} does not exist, therefore it was not deleted.`);
      }
    }
  });
};

const newBullet = (req, res) => {
  const todayDate = new Date();
  const mysqlDate = todayDate.toISOString().split("T")[0];
  const sql = `INSERT INTO "bullets" 
      (creation_date, 
      start_date, 
      end_date, 
      category_id, 
      strength, 
      summary, 
      narrative, 
      user_id, 
      bullet_format, 
      bullet_action, 
      bullet_impact, 
      bullet_result) 
    VALUES
      ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12);`;
  const body = req.body;
  const user_id = req.cookies.UID;
  const data = [
    mysqlDate,
    body.start_date,
    body.end_date,
    body.category_id,
    body.strength,
    body.summary,
    body.narrative,
    user_id,
    body.bullet_format,
    body.bullet_action,
    body.bullet_impact,
    body.bullet_result,
  ];
  pool.query(sql, data, (error, results) => {
    if (error) {
      throw error;
    }
    res.status(201).send(`New bullet was added.`);
  });
};

const searchBullets = (req, res) => {
  const searchString = req.query.search;
  const dbStr = `%${searchString.toLowerCase()}%`;
  pool.query(
    "SELECT * FROM Bullets WHERE LOWER(narrative) LIKE $1;",
    [dbStr],
    (error, results) => {
      if (error) {
        throw error;
      }
      res.status(200).send(results.rows);
    }
  );
};

const updateBullet = (req, res) => {
  const sql = `UPDATE bullets
                SET creation_date = ?,
                    start_date = ?,
                    end_date = ?,
                    category_id = ?,
                    strength = ?,
                    summary = ?,
                    narrative = ?,
                    bullet_format = ?,
                    bullet_action = ?,
                    bullet_impact = ?
                    bullet_result = ?
                WHERE bulletid = ?;`;
  const body = req.body;
  const id = parseInt(req.params.id);
  const data = [
    todayDate.toLocaleString,
    body.start_date,
    body.end_date,
    body.category_id,
    body.strength,
    body.summary,
    body.narrative,
    body.bullet_format,
    body.bullet_action,
    body.bullet_impact,
    body.bullet_result,
    id,
  ];

  const todayDate = new Date();
  pool.query(sql, data, (error, results, fields) => {
    if (error) {
      return console.error(error.message);
    }
    console.log("Rows affected:", results.affectedRows);
  });
};

module.exports = {
  login,
  getBullets,
  newBullet,
  getBulletsById,
  searchBullets,
  updateBullet,
  deleteBullet,
  getBulletIds,
};
