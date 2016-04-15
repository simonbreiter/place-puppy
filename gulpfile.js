var gulp = require('gulp');
var sass = require('gulp-sass');
var refresh = require('gulp-refresh');
var sourcemaps = require('gulp-sourcemaps');

gulp.task('sass:development', function() {
    return gulp.src('static/scss/**/*.scss')
                                .pipe(sourcemaps.init())
                                .pipe(sass().on('error', sass.logError))
                                .pipe(sourcemaps.write())
                                .pipe(gulp.dest('static/css'))
                                .pipe(refresh())
});

gulp.task('sass:release', function() {
    return gulp.src('static/scss/**/*.scss')
        .pipe(sass().on('error', sass.logError))
        .pipe(gulp.dest('static/css'))
});

gulp.task('sass:watch', function() {
    refresh.listen();
    gulp.watch('static/scss/**/*.scss', ['sass:development']);
});

gulp.task('default', ['sass:watch']);
gulp.task('dist', ['sass:release']);
