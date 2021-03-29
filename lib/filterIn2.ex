defmodule TipApps.FilterIn2 do
    @moduledoc """
        Own implementation. Correctly parses nested structure if pairs are matched properly, and head, tail are single character.
    """

    require Logger


    @doc """
        
    """

    def filterIn("", _head, _tail, _count) do
        ""
    end
    
    # When first character is head
    def filterIn(<<first>> <> str, head, tail, count) when first == head and count == 0 do
      filterIn(str, head, tail, count + 1)
    end
    
    def filterIn(<<first>> <> str, head, tail, count) when first == head and count > 0 do
      <<first::utf8>> <> filterIn(str, head, tail, count + 1)
    end
    
    
    # when first character is tail
    def filterIn(<<first>> <> str, head, tail, count) when first == tail and count == 1 do
      filterIn(str, head, tail, count - 1)
    end
    
    def filterIn(<<first>> <> str, head, tail, count) when first == tail and count > 1 do
      <<first::utf8>> <> filterIn(str, head, tail, count - 1)
    end
    
    
    # Normal case
    def filterIn(<<first>> <> str, head, tail, count) when count > 0 do
      <<first::utf8>> <> filterIn(str, head, tail, count)
    end
    
    def filterIn(<<_first>> <> str, head, tail, count) when count == 0 do
      filterIn(str, head, tail, count)
    end
    

    def filterIn(str,head,tail) do
      filterIn(str, head, tail, 0)
    end


    def test do
        IO.puts filterIn("abc()"  , ?( , ?)     )
        IO.puts filterIn("()abc"  , ?( , ?)      )
        IO.puts filterIn("abc()abc()"  , ?( , ?) )
        IO.puts filterIn("abc()abc()abc"  , ?( , ?) )
        IO.puts filterIn("abc(abc)abc()abc"  , ?( , ?) )
        IO.puts filterIn("abc(abc"  , ?( , ?))
        IO.puts filterIn("(Nested Test: ) abc((abc)123)"  , ?( , ?))
        IO.puts filterIn("(Multiple Clauses Test: ) abc(def)123(456)abc", ?(, ?))
    end

end