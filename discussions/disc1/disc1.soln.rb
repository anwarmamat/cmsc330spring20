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

    # This method inserts a tuple into the table following the specifications given for the insert method of the Database class.
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

    # This method selects tuples from the table following the specifications given for the select method of the Database class.
    # column_names is an Array of Strings
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

    # This method creates a new table in the database with the given table name. It returns true on success and false on failure.
    # The table will have the columns named in column_names.
    # If a table with table_name already exists, this is regarded as a failure.
    # table_name is a String
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

    # This method will return all tuples in table_name only for the corresponding column_names. The result is returned as an array of
    # tuples. Assume that table_name exists and the column_names match those of the table.
    # table_name is a String
    # column_names is a non empty Array of Strings
    def select(table_name, column_names)
        @db[table_name].selectTuples(column_names)
    end

    # This method will insert a tuple of size n into the table_name and return true on success and false on failure.
    # If the tuple size is not equal to the number of columns in the table, or the table_name does not exist, 
    # this is regarded as a failure.
    #
    # table_name is a String
    # data is a non empty Array whose elements form the tuple to be inserted into the table.
    def insert(table_name, data)
        @db[table_name].insertTuple(Tuple.new(data))
    end
end
