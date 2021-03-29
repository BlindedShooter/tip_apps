defmodule TipApps.FilterIn do
    @moduledoc """
        Modified filterOut.ex
    """

    require Logger


    @doc """
        
    """
    def getFront(str,head) do
        case String.split(str, head, parts: 2) do
            [_] -> ""
            [_, remain] -> remain
        end
    end

    def getRemain(str,tail) do
        case String.split(str, tail, parts: 2) do
            [_remain] -> {"", _remain}
            [content, remain] -> {content, remain}
        end
    end

    def filterIn("",_head,_tail) do
        ""
    end

    def filterIn(str,head,tail) do
        remain = getFront(str,head)
        {content, remain} = getRemain(remain,tail)
        
        content <> filterIn(remain,head,tail)
    end

    def test do
        IO.puts filterIn("abc()"  , "(" , ")"     )
        IO.puts filterIn("()abc"  , "(" , ")"      )
        IO.puts filterIn("abc()abc()"  , "(" , ")" )
        IO.puts filterIn("abc()abc()abc"  , "(" , ")" )
        IO.puts filterIn("abc(abc)abc()abc"  , "(" , ")" )
        IO.puts filterIn("abc(abc"  , "(" , ")" )
        IO.puts filterIn("abc((abc)123)"  , "(" , ")" )
        IO.puts filterIn("(Nested Test: ) abc((abc)123)"  , "(" , ")")
        IO.puts filterIn("(Multiple Clauses Test: ) abc(def)123(456)abc", "(", ")")
    end

end
