# We will be implimenting a simple database using Ruby data structures to store the data.
# A database can contain an arbitrary number of tables. Each table will contain tuples of size n, where n is the number of columns in
# the table.
# Through a series of discussion exercises each week, we will improve upon our simple database.
# This week we will create a Database representation that will implement some basic functionality.
# The class Tuple represents and entry in a table.
# The class Table represents a collection of tuples.
# The class Database represents the entire system of Tables against which a user can run queries.

class Tuple
    def initialize(data)
        @data = data;
    end

    # This method returns the number of enries in a tuple
    def getSize()
        return @data.length();
    end

    # This method returns the data at a particular index of a tuple (0 indexing)
    # If the provided index exceeds the largest index in the tuple, nil should be returned.
    # index is an Integer representing a valid index in the tuple.
    def getData(index)
        if index > (getSize() - 1) then
            nil
        else
            @data[index]
        end
    end
end

class Table
    # column_names is an Array of Strings
    def initialize(column_names)
        @column_names = column_names;
        @tuples = [];
    end

    # This method returns the number of tuples in the table
    def getSize
        @tuples.length()
    end

    # This method inserts a tuple into the table. It will return true on success and false on failure.
    # If the tuple's size is not equal to the number of columns in the table,
    # this is regarded as a failure.
    #
    # tuple is an instance of class Tuple declared above.
    def insertTuple(tuple)
        col_length = @column_names.length();
        tuple_size = tuple.getSize;

        if tuple_size != col_length then
            false
        else
            @tuples.push(tuple);
            true
        end
    end

    # This method narrows down each tuple in the table to include data from only columns whose names appear in column_names.
    # The resulting tuples are returned as an array of tuples.
    #
    # column_names is an Array of Strings.
    # The code block takes in a tuple and returns true if the tuple satisfies its desired conditions and false otherwise.
    def selectTuples(column_names)
        result = [];
        for tuple in @tuples do
            tuple_data = [];

            for name in column_names do
                tuple_data.push(tuple.getData(@column_names.index(name)));
            end

            result.push(Tuple.new(tuple_data));
        end
        result
    end
end

class Database
    def initialize()        
        # The database will be represented by a hash of table names as keys and tables as values. Since table names must be unique,
        # this will allow for faster lookup.
        @db = {};
    end

    # This method creates a new table in the database with the given table name. It returns an Integer on success and nil on failure.
    # The table will have the columns named in column_names.
    # If a table with table_name already exists, this is regarded as a failure.
    # If the table_name does not match the specification below, this is also a failure.
    # Return the numeric part of the table name (0 if non) as an Integer on success.
    #
    # table_name is a String that starts with an uppercase letter, followed by any number of lower case letters, and could end
    # with a number in the set [1, 1000] (trailing 0's allowed e.g 00094). 
    # column_names is a non empty Array of Strings
    def createTable(table_name, column_names)
        if @db[table_name] == nil then
            @db[table_name] = (Table.new(column_names));
            true
        else
            false
        end
    end

    # This method will delete table_name from the database. All of its tuples will be deleted in the process.
    # This method will return true on success and false on failure.
    # If the table name is not found, this is regarded as a failure.
    # table_name is a String
    def dropTable(table_name)
        if @db[table_name] then
            @db.delete(table_name);
            true
        else
            false
        end
    end

    # This method returns an array of tuples, where each tuple has been narrowed down to include only 
    # the data that belongs to columns whose names are in column_names.
    # If a code block is passed in, the final result should be filtered through that code block.
    # Only tuples for which the code block returns true should be included in the final array of tuples that is returned.
    # Assume that table_name exists and column_names is a subset of the names of the columns of the table.
    #
    # table_name is a String
    # column_names is a non empty Array of Strings
    def select(table_name, column_names)
        @db[table_name].selectTuples(column_names);
    end

    # This method will insert a tuple of size n into the table_name and return true on success and false on failure.
    # If the tuple size is not equal to the number of columns in the table, or the table_name does not exist, 
    # this is regarded as a failure.
    #
    # table_name is a String
    # data is a non empty Array whose elements form the tuple to be inserted into the table.
    def insert(table_name, data)
        if @db[table_name] then
            @db[table_name].insertTuple(Tuple.new(data))
        else
            false
        end
    end
end
