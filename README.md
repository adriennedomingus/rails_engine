#### Introduction
This project was completed as a module 3 project at the Turing School of Software and Design. Main learning goals included:
* Serving an internal API
* More advanced Active Record querying techniques

The project provides API endpoints to see details about merchants, customers, and their interactions. The [project description](https://github.com/turingschool/lesson_plans/blob/master/ruby_03-professional_rails_applications/rails_engine.md#learning-goals) includes more details about what can be found at each endpoint.

#### Setup

* Clone the project down  
* `cd` into the project directory  
* `bundle`  
* To set up the database, run `rake db:create db:migrate db:import_csv` This imports data from included CSV files into the database, and may take several minutes.

#### Test Suite

The test suite is written in RSpec, and uses a combination of request specs and model specs. After running `rake db:migrate RAILS_ENV=test`, the entire suite can be run with `rspec`.   

A spec harness and instructions for its usage can be found [here](https://github.com/turingschool/rales_engine_spec_harness)
