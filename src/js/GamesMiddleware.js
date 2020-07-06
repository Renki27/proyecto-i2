module.exports = {
    validateGame: (game) => {
        const currentTime = new Date();
        const year = currentTime.getFullYear();
        // username min length 3
        if (!game.title || game.title.length < 3) {
            return 'Please enter a game title with at least 3 chars'
        }
        // password (repeat) does not match
        if (game.released_on < 1970 || game.released_on > year) {
            return 'Invalid date, please check the released on field'
        }
        if (!game.video_link.includes("https://www.") && !game.video_link.includes(".com")) {
            return 'Trailer video field must have a video link'
        }

        if (!game.video_link || game.video_link.length < 40) {
            return 'Please enter a valid video link'
        }
        if (game.video_link.includes("youtube") || game.video_link.includes("vimeo") || game.video_link.includes("dailymotion")) {
            return ""
        }
        else {
            return 'Only videos from YouTube, Vimeo and Dailymotion are supported!'
        }
        return ""
    }
};