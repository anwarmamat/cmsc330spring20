require "minitest/autorun"
require_relative "disc2.rb"

class Tests < Minitest::Test
    def setup
        @tuple = Tuple.new(["a", 1, "b", 2]);
        @table = Table.new(["c0", "c1", "c2"]);
        @db = Database.new();
        @db.createTable("Table1", ["c1", "c2"]);
        @db.createTable("Table2", ["c3", "c4"]);
        @db.createTable("Table3", ["c1", "c2", "c3"]);
    end

    def test_GetSize
        result = @tuple.getSize();
        assert_equal(4, result, "Expected 4, found #{result}");
    end

    def test_GetDataSuccess
        result = @tuple.getData(0);
        assert_equal("a", result , "Expected a, found #{result}");
    end

    def test_GetDataFailure
        result = @tuple.getData(4);
        assert_nil(result, "Expected nil, found #{result}");
    end

    def test_InsertValidTuple
        assert(@table.insertTuple(Tuple.new([1,2,3])), "Expected successful insertion of tuple");
        result = @table.getSize();
        assert_equal(1, result, "Expected table of size 1, found size #{result}");

        @table.insertTuple(Tuple.new([4,5,6]));
        @table.insertTuple(Tuple.new([7,8,9]));
        result = @table.getSize();
        assert_equal(3, result, "Expected table of size 1, found size #{result}");
    end

    def test_InsertInvalidTuple
        assert(!@table.insertTuple(Tuple.new([1,2,3,4])), "Expected failed insertion of tuple");
        result = @table.getSize();
        assert_equal(0, result, "Expected table of size 0, found #{result}");
    end

    def test_SelectTuples
        @table.insertTuple(Tuple.new([1, 2, 3]));
        result = @table.selectTuples(["c1", "c2"]);
        assert_equal(1, result.length(), "Expected result of size 1, found #{result.length()}");
        assert_equal(2, result[0].getSize(), "Expected tuples of size 2, found tuples of size #{result[0].getSize()}");
        data = result[0].getData(0);
        assert_equal(2, data, "Expected 2, found #{data}");
        data = result[0].getData(1);
        assert_equal(3, data, "Expected 3, found #{data}");

        @table.insertTuple(Tuple.new(["a", "b", "c"]));
        result = @table.selectTuples(["c2"]);
        assert_equal(2, result.length(), "Expected result of size 2, found #{result.length()}");
        assert_equal(1, result[0].getSize(), "Expected tuples of size 1, found tuples of size #{result[0].getSize()}");
        assert_equal(1, result[1].getSize(), "Expected tuples of size 1, found tuples of size #{result[1].getSize()}");

        data = result[1].getData(0);
        assert_equal("c", data, "Expected c, found " + data.to_s());
    end

    def test_CreateTableSuccess
       assert_equal(4, @db.createTable("Table4", ["c1", "c2"]), "Expected successful creation of table with number 4");
       assert_equal(5, @db.createTable("Table5", ["c1", "c2"]), "Expected successful creation of table with number 5");
       assert_equal(91,@db.createTable("Table0000000091", ["c1", "c2"]), "Expected successful creation of table with number 91");
       assert_equal(1000,@db.createTable("Table1000", ["c1", "c2"]), "Expected successful creation of table with number 1000");
       assert_equal(0, @db.createTable("Table", ["c1", "c2"]), "Expected successful creation of table with no number");
       assert_equal(0, @db.createTable("T", ["c1", "c2"]), "Expected successful creation of table with no number and name of length 1");

       @db.dropTable("Table1000");

       assert_equal(1000,@db.createTable("Table001000", ["c1", "c2"]), "Expected successful creation of table with number 1000");

    end

    def test_CreatTableFailure
        assert_nil(nil, @db.createTable("Table1", ["c4", "c5"]));
        assert_nil(nil, @db.createTable("Table1001", ["c4", "c5"]));
        assert_nil(nil, @db.createTable("Table9999", ["c4", "c5"]));
        assert_nil(nil, @db.createTable("Table09999", ["c4", "c5"]));
        assert_nil(nil, @db.createTable("Table10000", ["c4", "c5"]));
        assert_nil(nil, @db.createTable("table", ["c4", "c5"]));
    end

    def test_DropTableSuccess
        assert(@db.dropTable("Table1"));
    end

    def test_DropTableFailure
        assert(!@db.dropTable("Table20"));
        new_db = Database.new();
        assert(!new_db.dropTable("Table1"));
    end

    def test_InsertSuccess
        assert(@db.insert("Table1", ["a", "b"]));
        assert(@db.insert("Table1", ["c", "d"]));
        assert(@db.insert("Table2", ["1", "5"]));
    end

    def test_InsertFailure
        assert(!@db.insert("Table1", ["a", "b", "c"]));
        assert(!@db.insert("Table1", ["c"]));
        assert(!@db.insert("Table2", []));
    end

    def test_Select
        @db.insert("Table1", ["a", "b"]);
        @db.insert("Table1", ["c", "d"]);
        result = @db.select("Table1", ["c1"]);
        assert_equal(2, result.length(), "Expected result of size 2, found result of size #{result.length()}");
        
        result = @db.select("Table2", ["c4"]);
        assert_equal(0, result.length(), "Expected result of size 0, found result of size #{result.length()}");
    end

    def test_SelectWithCodeBlock
        @db.insert("Table3", ["a", "b", "c"]);
        @db.insert("Table3", ["1", "2", "3"]);
        @db.insert("Table3", ["A", "B", "C"]);
        
        result = @db.select("Table3", ["c1", "c3"]) do |tuple|
                    if tuple.getData(0) == "a" || tuple.getData(0) == "A" then
                        true
                    else
                        false
                    end
                end
        assert_equal(2, result.length(), "Expected an array of lenght 2, found one of length #{result.length()}");
    end
end
