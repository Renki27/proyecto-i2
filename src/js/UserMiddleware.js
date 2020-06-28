module.exports = {
  validateUser: (user) => {
    // username min length 3
    if (!user.username || user.username.length < 3) {
      return 'Please enter a username with min. 3 chars'
    }
    // password min 6 chars
    if (!user.password || user.password.length < 6) {
      return 'Please enter a password with min. 6 chars'
    }
    // password (repeat) does not match
    if (
      !user.password_confirm ||
      user.password != user.password_confirm
    ) {
      return 'Both passwords must match'
    }
    return ""
  }
};