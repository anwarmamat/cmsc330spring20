require "minitest/autorun"
require_relative "disc1.rb"

class Tests < Minitest::Test
    def setup
        @tuple = Tuple.new(["a", 1, "b", 2]);
        @table = Table.new(["c0", "c1", "c2"]);
        @db = Database.new();
        @db.createTable("table1", ["c1", "c2"]);
        @db.createTable("table2", ["c3", "c4"]);
    end

    def test_GetSize
        result = @tuple.getSize();
        assert_equal(4, result, "Expected 4, found " + result.to_s());
    end

    def test_GetDataSuccess
        result = @tuple.getData(0);
        assert_equal("a", result , "Expected a, found " + result.to_s());
    end

    def test_GetDataFailure
        result = @tuple.getData(4);
        assert_nil(result, "Expected nil, found " + result.to_s());
    end

    def test_InsertValidTuple
        assert(@table.insertTuple(Tuple.new([1,2,3])), "Expected successful insertion of tuple");
        result = @table.getSize();
        assert_equal(1, result, "Expected table of size 1, found size " + result.to_s());

        @table.insertTuple(Tuple.new([4,5,6]));
        @table.insertTuple(Tuple.new([7,8,9]));
        result = @table.getSize();
        assert_equal(3, result, "Expected table of size 1, found size " + result.to_s());
    end

    def test_InsertInvalidTuple
        assert(!@table.insertTuple(Tuple.new([1,2,3,4])), "Expected failed insertion of tuple");
        result = @table.getSize();
        assert_equal(0, result, "Expected table of size 0, found " + result.to_s());
    end

    def test_SelectTuples
        @table.insertTuple(Tuple.new([1, 2, 3]));
        result = @table.selectTuples(["c1", "c2"]);
        assert_equal(1, result.length(), "Expected result of size 1, found " + result.length().to_s());
        assert_equal(2, result[0].getSize(), "Expected tuples of size 2, found tuples of size " + result[0].getSize().to_s());
        data = result[0].getData(0);
        assert_equal(2, data, "Expected 2, found " + data.to_s());
        data = result[0].getData(1);
        assert_equal(3, data, "Expected 3, found " + data.to_s());

        @table.insertTuple(Tuple.new(["a", "b", "c"]));
        result = @table.selectTuples(["c2"]);
        assert_equal(2, result.length(), "Expected result of size 2, found " + result.length().to_s());
        assert_equal(1, result[0].getSize(), "Expected tuples of size 1, found tuples of size " + result[0].getSize().to_s());
        assert_equal(1, result[1].getSize(), "Expected tuples of size 1, found tuples of size " + result[0].getSize().to_s());

        data = result[1].getData(0);
        assert_equal("c", data, "Expected c, found " + data.to_s());
    end

    def test_CreateTableSuccess
       assert(@db.createTable("table3", ["c1", "c2"]), "Expected successful creation of table");
       assert(@db.createTable("table4", ["c1", "c2"]), "Expected successful creation of table");

    end

    def test_CreatTableFailure
        assert(!@db.createTable("table1", ["c4", "c5"]), "Expected failed creation of table");
    end

    def test_DropTableSuccess
        assert(@db.dropTable("table1"));
    end

    def test_DropTableFailure
        assert(!@db.dropTable("table20"));
        new_db = Database.new();
        assert(!new_db.dropTable("table1"));
    end

    def test_InsertSuccess
        assert(@db.insert("table1", ["a", "b"]));
        assert(@db.insert("table1", ["c", "d"]));
        assert(@db.insert("table2", ["1", "5"]));
    end

    def test_InsertFailure
        assert(!@db.insert("table1", ["a", "b", "c"]));
        assert(!@db.insert("table1", ["c"]));
        assert(!@db.insert("table2", []));
    end

    def test_Select
        @db.insert("table1", ["a", "b"]);
        @db.insert("table1", ["c", "d"]);
        result = @db.select("table1", ["c1"]);
        assert_equal(2, result.length(), "Expected result of size 2, found result of size " + result.length.to_s());
        
        result = @db.select("table2", ["c4"]);
        assert_equal(0, result.length(), "Expected result of size 0, found result of size " + result.length.to_s());
    end
end
