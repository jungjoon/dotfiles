# irb init file

def commify(str, step = 4)
    # str.gsub(/(\d)(?=\d{4}+(?:\.|$))(\d{4}\..*)?/,'\1,\2')
    str.gsub(/(.)(?=.{#{step}}+(?:\.|$))(.{#{step}}\..*)?/,'\1,\2')
end

module ByteCalc
    def kb
        self * 1024
    end

    def mb
        kb * 1024
    end

    def gb
        mb * 1024
    end

    def x
        "0x " + commify(to_s 16)
    end

    def b
        "0b " + commify(to_s 2)
    end

    def d
        "0d " + commify(to_s, 3)
    end

    def bm
        self / 1.mb.to_f
    end

    def bg
        self / 1.gb.to_f
    end

    def b_print_set_bit
        ret = ""
        t = self
        bit = 0
        while t != 0 do
            if (t & 1) == 1 then
                ret += "bit #{bit}\n"
            end
            t = (t >> 1)
            bit += 1
        end

        ret
    end

    def inspect
        "#{d} / #{x} / #{b}" + "\n" + (b_print_set_bit)
    end
end

class Fixnum
    include ByteCalc
end

class Bignum
    include ByteCalc
end



require 'irb/completion'
require 'what_methods'
require 'pp'

IRB.conf[:AUTO_INDENT]=true


