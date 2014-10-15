# Advanced Postgresql Datatypes

A presentation and notes.

Originally given at CoverMyMeds, 10/10/2014

## Getting Started

### Create the Database

To run the examples, you'll want to create the database. The code in `connect.rb` is
expecting a database named `pg-datatypes-demo`.

### Load the Schema

Running `ruby schema.rb` will create the necessary tables and indexes. It will destroy
any data that's already in those tables.

### Running the Demos

`array_demo.rb` and `hstore_demo.rb` contain some short demonstrations of the
functionality discussed in the presentation. You can run them from the command line
to see the logged SQL, or load them in IRB to work more with the models.

### Running the Benchmarks

`array_bench.rb` and `hstore_bench.rb` contain some benchmarks. It's quite possible
that they provide results that are incorrect; more investigation is needed. Here's
the output on my machine (ruby 2.1.2, ActiveRecord 4.2.0.beta2):

```
# array_bench.rb
pg-datatypes (mj: master) ~ ruby array_bench.rb
                      user     system      total        real
loading posts:   11.740000   0.700000  12.440000 ( 15.750509)
loading plain:  131.460000   4.150000 135.610000 (147.130202)
100000
Calculating -------------------------------------
         array count       103 i/100ms
          join count        24 i/100ms
          array load        68 i/100ms
           join load         7 i/100ms
        include load         2 i/100ms
        array load L         8 i/100ms
         join load L         1 i/100ms
      include load L         1 i/100ms
     array load tags         7 i/100ms
      join load tags         6 i/100ms
   include load tags         2 i/100ms
-------------------------------------------------
         array count     1058.7 (±5.8%) i/s -      15862 in  15.040766s
          join count      246.1 (±5.7%) i/s -       3696 in  15.065468s
          array load      699.6 (±10.0%) i/s -      10404 in  15.033673s
           join load       73.2 (±6.8%) i/s -       1099 in  15.070521s
        include load       24.2 (±12.4%) i/s -        356 in  15.000360s
        array load L       88.5 (±6.8%) i/s -       1328 in  15.079335s
         join load L        7.5 (±0.0%) i/s -        112 in  15.027930s
      include load L        3.2 (±0.0%) i/s -         49 in  15.195219s
     array load tags       76.6 (±7.8%) i/s -       1141 in  15.008086s
      join load tags       62.5 (±8.0%) i/s -        930 in  15.002618s
   include load tags       22.7 (±8.8%) i/s -        336 in  15.035043s
```

```
# hstore_bench.rb
pg-datatypes (mj: master) ~ ruby hstore_bench.rb
                      user     system      total        real
loading pawns:   17.180000   1.000000  18.180000 ( 22.483944)
Calculating -------------------------------------
            find one        94 i/100ms
-------------------------------------------------
            find one      784.2 (±3.6%) i/s -      11750 in  15.002092s
```
