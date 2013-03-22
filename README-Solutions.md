# Solution to the proposed stories

## Story 1
The problem with speed was mainly related to 2 different issues

### The **SELECT+1** problem
When we query every deal we get a list of all deals, but only of the data contained in the deals table. But then we use the relationships in the view for each row and we trigger 2 more queries, one for the advertiser and another for the publisher.

### Solution
Include the necessary fields in the query using **:include**

### Other solutions
We could have used a page cache and a cache sweeper to cache the whole page.

## Story 2

### Dry the themes
We had 4 themes that were basically the same 

### Solution
Create one theme and use variables to show the differences between them, and use some logic in the controller to load the correct theme.
## Story 3

### Make the tests more reliable
Testing expiration dates is always cumbersome.

### Solution
Enter Timecop, with this gem is very easy to test for time related issues, it basically patches the Time class so when we ask for the time inside a test it shows us what we want to see.

## Story 4

### Import daily_planet data
We have to find a clean way to import data. The solution should be flexible enough to reuse with different files or different publishers.

### Solution
Encapsulated all the logic in 2 classes inside **lib/support/loaders.rb**
Created a rake task that accepts params to locate the file.
The classes are quete extensible, we can change the regexp they use to locate the fields, if they expect a header, etc.

To run use this rake import task:

```
rake import:daily_planet[script/data/daily_planet_export.txt]
```

OR

```
rake import:daily_planet 
# This searches for the file in script/data/daily_planet_export.txt
```