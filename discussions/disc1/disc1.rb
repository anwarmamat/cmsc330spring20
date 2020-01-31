# We will be implimenting a simple database using Ruby data structures to store the data.
# A database can contain an arbitrary number of tables. Each table will contain tuples of size n, where n is the number of columns in
# the table.
# Through a series of discussion exercises each week, we will improve upon our simple database.
# This week we will create a Database representation that will implement some basic functionality.
# The class Tuple represents and entry in a table.
# The class Table represents a collection of tuples.
# The class Database represents the entire system of Tables against which a user can run queries.

class Tuple
    # data is an array of values for the tuple
    def initialize(data)
        raise "unimplemented"
    end

    # This method returns the number of enries in a tuple
    def getSize()
        raise "unimplemented"
    end

    # This method returns the data at a particular index of a tuple (0 indexing)
    # If the provided index exceeds the largest index in the tuple, nil should be returned.
    # index is an Integer representing a valid index in the tuple.
    def getData(index)
        raise "unimplemented"
    end
end

class Table
    # column_names is an Array of Strings
    def initialize(column_names)
        raise "unimplemented"
    end

    # This method returns the number of tuples in the table
    def getSize
        raise "unimplemented"
    end

    # This method inserts a tuple into the table following the specifications given for the insert method of the Database class.
    # tuple is an instance of class Tuple declared above.
    def insertTuple(tuple)
        raise "unimplemented"
    end

    # This method selects tuples from the table following the specifications given for the select method of the Database class.
    # column_names is an Array of Strings
    def selectTuples(column_names)
        raise "unimplimented"
    end
end

class Database
    def initialize()        
        # What data structure should we use to represent the database and why?
        raise "unimplemented"
    end

    # This method creates a new table in the database with the given table name. It returns true on success and false on failure.
    # The table will have the columns named in column_names.
    # If a table with table_name already exists, this is regarded as a failure.
    # table_name is a String
    # column_names is a non empty Array of Strings
    def createTable(table_name, column_names)
       raise "unimplemented"
    end

    # This method will delete table_name from the database. All of its tuples will be deleted in the process.
    # This method will return true on success and false on failure.
    # If the table name is not found, this is regarded as a failure.
    # table_name is a String
    def dropTable(table_name)
        raise "unimplemented"
    end

    # This method will return all tuples in table_name only for the corresponding column_names. The result is returned as an array of
    # tuples. Assume that table_name exists and the column_names match those of the table.
    # table_name is a String
    # column_names is a non empty Array of Strings
    def select(table_name, column_names)
        raise "unimplemented"
    end

    # This method will insert a tuple of size n into the table_name and return true on success and false on failure.
    # If the tuple size is not equal to the number of columns in the table, or the table_name does not exist, 
    # this is regarded as a failure.
    #
    # table_name is a String
    # data is a non empty Array whose elements form the tuple to be inserted into the table.
    def insert(table_name, data)
        raise "unimplemented"
    end
end
