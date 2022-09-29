//user route
const router = require('express').Router()
const auth = require("../middleware/auth.js")
const userController = require("../controllers/user.controller.js")
const upload = require("../middleware/fileupload.js")

router.post("/user/register", userController.register_user);

router.post("/user/login", userController.login_user);

router.post("/admin/register", userController.register_admin);

router.post("/admin/login", userController.login_admin);

router.get("/user", auth.checkAuth, userController.get_user_detail);

router.put("/user/update", auth.checkAuth, userController.update_user);

router.put("/user/update-profile", auth.checkAuth, upload.single("image"), userController.update_user_picture);

router.get("/user/cart", auth.checkAuth, userController.view_cart);

router.put("/user/cart/:id", auth.checkAuth, userController.add_to_cart);

router.put("/user/checkout", auth.checkAuth, userController.checkout_cart);

module.exports = router;
