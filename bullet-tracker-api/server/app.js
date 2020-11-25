const fs = require("fs");
const bodyParser = require("body-parser");
const cookieParser = require("cookie-parser");
const express = require("express");
const app = express();
const port = 3001;
const db = require("./queries");
const fetch = require("node-fetch"); //allows external API calls

// fetch("http://localhost:6001/users/1") //calls Ada's Account Management System
//   .then(
//     //need to replace user id "1" with current session user ID
//     (res) => res.text()
//   )
//   .then((body) => console.log("Fetch Body:", body))
//   .catch((err) => console.error(err));

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(cookieParser());
app.use(
  bodyParser.urlencoded({
    extended: true,
  })
);

app.use("/", (req, res, next) => {
  //after each request, logs the path
  console.log("Received request: " + req.originalUrl);
  next(); // Passes control to the next middleware function. Otherwise, the request will be left hanging.
});

app.on("connection", (req, res, next) => {
  //sets default cookie for mocking purposes
  let adminUser = { UID: "admin" };
  let result;
  if (adminUser.UID) {
    result = { status: "success", message: "You are logged in." };
    res.cookie("UID", adminUser.UID);
    console.log("Cookies:", res.cookies.UID);
  } else {
    result = {
      status: "failed",
      message: "You have not logged in. Try /login.",
    };
    res.status(404);
  }
  res.json(result);
  res.end();
});

app.post("/login", db.login); //sets user ID cookie

app.get("/bullets", db.getBullets); //selects all of the user's bullets

app.get("/bullets/:id", db.getBulletsById); //selects bullets by bulletid

app.get("/bulletids", db.getBulletIds); //selects all bullet ids

app.get("/search", db.searchBullets); //searches the narrative column for query, returns all bullets with the string

app.post("/new", db.newBullet); //inserts new bullets into bullets table

app.patch("/update/:id", db.updateBullet); //updates bullet by bullet id

app.delete("/delete/:id", db.deleteBullet); //deletes bullet by bullet id

app.listen(port, () =>
  console.log(`Bullet Tracker Server listening at http://localhost:${port}`)
);
