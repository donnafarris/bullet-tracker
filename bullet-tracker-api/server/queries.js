//handlers and DB integration

const Pool = require("pg").Pool;
const pool = new Pool({
  user: "postgres",
  host: "localhost",
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
  client.query(
    // change query to be like getBullets
    "SELECT * FROM bullets WHERE user_id = $1 ORDER BY bulletid ASC",
    [1],
    (err, res) => {
      done();
      if (err) {
        console.log("Bullet Select Error:", err.stack);
      } else {
        return res.rows[0];
      }
    }
  );
});

//get bullets by userID ✓
//post new bullets ✓
//remove bullets
//edit bullets

const login = (req, res) => {
  let userCookie = req.body;
  let result;
  if (userCookie.UID) {
    result = { status: "success", message: "You are logged in." };
    res.cookie("UID", userCookie.UID);
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
  if (req.cookies) {
    let UID = req.cookies.UID;
    pool.query(
      "SELECT * FROM Bullets WHERE bulletid = $1 ORDER BY bulletid ASC",
      [1],
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

const getBulletsById = (req, res) => {
  const id = parseInt(req.params.id);
  pool.query(
    "SELECT * FROM Bullets WHERE BulletId = $1",
    [id],
    (error, results) => {
      if (error) {
        throw error;
      }
      res.status(200).json(results.rows);
    }
  );
};

const newBullet = (req, res) => {
  const {
    startdate,
    enddate,
    strength,
    categoryID,
    bulletformat,
    bulletaction,
    bulletimpact,
    bulletresult,
    bulletnarrative,
    summary,
  } = req.body;
  const todayDate = new Date();
  const user_id = req.cookies.UID;
  pool.query(
    "INSERT INTO Bullets (StartDate, EndDate, Strength, CategoryId, BulletFormat, BulletAction, BulletImpact, BulletResult, BulletNarrative, Summary, CreationDate, user_id) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12)",
    [
      startdate,
      enddate,
      strength,
      categoryID,
      bulletformat,
      bulletaction,
      bulletimpact,
      bulletresult,
      bulletnarrative,
      summary,
      todayDate.toLocaleString(),
      user_id,
    ],
    (error, res) => {
      if (error) {
        throw error;
      }
      res.status(201).send("New bullet was added.");
    }
  );
};

const searchBullets = (req, res) => {
  const searchString = req.query.search;
  const dbStr = `%${searchString.toLowerCase()}%`;
  pool.query(
    "SELECT * FROM Bullets WHERE LOWER(BulletNarrative) LIKE $1",
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
  const {
    startdate,
    enddate,
    strength,
    categoryID,
    bulletformat,
    bulletaction,
    bulletimpact,
    bulletresult,
    bulletnarrative,
    summary,
  } = req.body;
  const todayDate = new Date();
  pool.query("UPDATE Bullets SET $ WHERE BulletId = $");
};

module.exports = {
  login,
  getBullets,
  newBullet,
  getBulletsById,
  searchBullets,
};
