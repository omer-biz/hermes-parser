local P = require("parser")

describe("parser", function()
  it("should parse regularly", function()
    local p = P.identifier("ident")
        :debug(function(result, rest)
          assert.are.equal(result, "ident")
          assert.are.equal(rest, " everything else") -- notice the extra space there, that's because P.space1() is not run yet
        end):take_after(P.space1())

    local out, rest = p:parse("ident everything else")
    assert.are.equal(out, "ident")
    assert.are.equal(rest, "everything else")
  end)
end)
