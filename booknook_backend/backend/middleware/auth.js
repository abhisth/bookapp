//auth 
const jwt = require("jsonwebtoken");
const Users = require("../models/user");

module.exports.checkAuth = async function (req, res, next) {
  try {
    const token = req.headers.authorization.split(" ")[1];
    const data = jwt.verify(token, "token");
    const user = await Users.findOne({ _id: data._id }).populate("cart")
    if (user){
      req.user = user;
      next();
    }
    else{
    res.json({ message: "Unauthorized!!", success: false });

    }
  } catch (e) {
    res.json({ error: e });
  }
};

module.exports.verifyAdmin = function (req, res, next) {
  if (!req.user) {
    return res.status(401).json({ message: "Unauthorized!!", success: false });
  } else if (req.user.userType !== "Admin") {
    return res.status(401).json({ message: "Unauthorized!!", success: false });
  }
  next();
};
