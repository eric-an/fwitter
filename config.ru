require './config/environment'

use Rack::MethodOverride
use UsersController
use TweetsController
run ApplicationController