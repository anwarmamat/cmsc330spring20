#!/usr/local/bin/ruby

require "minitest/autorun"
require_relative "maze.rb"

$MAZE1 = "inputs/maze1"
$MAZE2 = "inputs/maze2"
$MAZE3 = "inputs/maze3"

$MAZE1_STD = "inputs/maze1-std"
$MAZE1B_STD = "inputs/maze1b-std"
$MAZE2_STD = "inputs/maze2-std"
$MAZE3_STD = "inputs/maze3-std"
$MAZE4_STD = "inputs/maze4-std"


class PublicTests < Minitest::Test

    def test_public_bridge
        assert_equal(6, main("bridge", $MAZE1))
        assert_equal(6, main("bridge", $MAZE2))
        assert_equal(6, main("bridge", $MAZE3))
    end

    def test_public_distance
    	$OUTPUT_MAZE1 = File.read("outputs/public_distance_maze1.out")
    	$OUTPUT_MAZE2 = File.read("outputs/public_distance_maze2.out")
    	$OUTPUT_MAZE3 = File.read("outputs/public_distance_maze3.out")

        assert_equal($OUTPUT_MAZE1, main("distance", $MAZE1))
        assert_equal($OUTPUT_MAZE2, main("distance", $MAZE2))
        assert_equal($OUTPUT_MAZE3, main("distance", $MAZE3))
    end

    def test_public_open
        assert_equal(2, main("open", $MAZE1))
        assert_equal(2, main("open", $MAZE2))
        assert_equal(2, main("open", $MAZE3))
    end

    def test_public_parse
    	$OUTPUT_MAZE1 = File.read("outputs/public_parse_maze1-std.out")
    	$OUTPUT_MAZE1B = File.read("outputs/public_parse_maze1b-std.out")
    	$OUTPUT_MAZE2 = File.read("outputs/public_parse_maze2-std.out")
    	$OUTPUT_MAZE3 = File.read("outputs/public_parse_maze3-std.out")
    	$OUTPUT_MAZE4 = File.read("outputs/public_parse_maze4-std.out")

        assert_equal($OUTPUT_MAZE1, main("parse", $MAZE1_STD))
        assert_equal($OUTPUT_MAZE1B, main("parse", $MAZE1B_STD))
        assert_equal($OUTPUT_MAZE2, main("parse", $MAZE2_STD))
        assert_equal($OUTPUT_MAZE3, main("parse", $MAZE3_STD))
        assert_equal($OUTPUT_MAZE4, main("parse", $MAZE4_STD))
    end

    def test_public_paths
    	$OUTPUT_MAZE1 = File.read("outputs/public_paths_maze1.out")
    	$OUTPUT_MAZE2 = File.read("outputs/public_paths_maze2.out")
    	$OUTPUT_MAZE3 = File.read("outputs/public_paths_maze3.out")

        assert_equal($OUTPUT_MAZE1, main("paths", $MAZE1))
        assert_equal($OUTPUT_MAZE2, main("paths", $MAZE2).join("\n"))
        assert_equal($OUTPUT_MAZE3, main("paths", $MAZE3).join("\n"))
    end

    def test_public_print
    	$OUTPUT_MAZE1 = File.read("outputs/public_print_maze1.out")
    	$OUTPUT_MAZE2 = File.read("outputs/public_print_maze2.out")
    	$OUTPUT_MAZE3 = File.read("outputs/public_print_maze3.out")

        assert_equal($OUTPUT_MAZE1, main("print", $MAZE1))
        assert_equal($OUTPUT_MAZE2, main("print", $MAZE2))
        assert_equal($OUTPUT_MAZE3, main("print", $MAZE3))
    end

    def test_public_solve
        assert_equal(true, main("solve", $MAZE1))
        assert_equal(true, main("solve", $MAZE2))
        assert_equal(false, main("solve", $MAZE3))
    end

    def test_public_sortcells
    	$OUTPUT_MAZE1 = File.read("outputs/public_sortcells_maze1.out")
    	$OUTPUT_MAZE2 = File.read("outputs/public_sortcells_maze2.out")
    	$OUTPUT_MAZE3 = File.read("outputs/public_sortcells_maze3.out")

        assert_equal($OUTPUT_MAZE1, main("sortcells", $MAZE1).join("\n"))
        assert_equal($OUTPUT_MAZE2, main("sortcells", $MAZE2).join("\n"))
        assert_equal($OUTPUT_MAZE3, main("sortcells", $MAZE3).join("\n"))
    end
end
