module FP
  struct FixedPoint(Underlying, Scale) < Number
    # Underlying is what type we'll be using
    # Scale that we will divide the underlying value with

    @underlying = Underlying.new(0)

    def self.zero : self
      self.new
    end

    def self.new_from_underlying(val : Underlying)
      fp = self.new
      fp.underlying = val
      fp
    end

    def initialize()
    end

    def initialize(val : self)
      @underlying = val.underlying
    end

    def initialize(val : Number)
      @underlying = Underlying.new(val * Scale)
    end

    def hash(hasher)
      @underlying.hash hasher
    end

    def modulo(other) : self
      if other == 0.0
        raise DivisionByZeroError.new
      else
        self - other * (self // other)
      end
    end

    def remainder(other) : self
      if other == 0.0
        raise DivisionByZeroError.new
      else
        mod = self % other
        return self.class.zero if mod == 0.0
        return mod if self > 0 && other > 0
        return mod if self < 0 && other < 0
  
        mod - other
      end
    end

    def floor : self
      self.class.new to_f.floor
    end

    def ceil : self
      self.class.new to_f.ceil
    end

    def trunc : self
      self.class.new to_f.trunc
    end

    def round_away : self
      self.class.new to_f.round_away
    end

    def round_even : self
      self.class.new to_f.round_even
    end

    def to_s(io : IO) : Nil
      to_f.to_s io
    end

    def to_f : Float64
      to_f64
    end

    def to_f64 : Float64
      (@underlying.to_f / Scale).to_f
    end

    def to_f32 : Float32
      (@underlying.to_f / Scale).to_f32
    end

    def to_i : Int32
      to_i32
    end

    def to_i64 : Int64
      (@underlying / Scale).to_i64
    end

    def to_i32 : Int32
      (@underlying / Scale).to_i32
    end

    def <=>(other : FixedPoint) : Int32
      return @underlying > other.underlying ? 1 : (@underlying < other.underlying ? -1 : 0)
    end

    def <=>(other : Float) : Int32?
      return nil if other.nan?

      return self <=> self.class.new(other)
    end

    def <=>(other : Int) : Int32
      return self <=> self.class.new(other)
    end

    def -() : self
      self.class.new_from_underlying -@underlying
    end

    def +(other : self) : self
      self.class.new_from_underlying @underlying + other.underlying
    end

    def -(other : self) : self
      self.class.new_from_underlying @underlying - other.underlying
    end

    def *(other : self) : self
      self.class.new_from_underlying @underlying * other.underlying // Scale
    end

    def /(other : self) : self
      self.class.new_from_underlying Underlying.new((@underlying / other.underlying) * Scale)
    end

    def %(other : self) : self
      self.class.new to_f % other.to_f
    end

    def **(other : self) : self
      exp = other.underlying / Scale
      underlying_component = @underlying ** exp
      scale_component = Scale ** (1 - exp)
      self.class.new_from_underlying Underlying.new(underlying_component * scale_component)
    end

    def +(other : Number) : self
      self + self.class.new(other)
    end

    def -(other : Number) : self
      self - self.class.new(other)
    end

    def *(other : Number) : self
      self * self.class.new(other)
    end

    def /(other : Number) : self
      self / self.class.new(other)
    end

    def %(other : Number) : self
      self % self.class.new(other)
    end

    def **(other : Number) : self
      self ** self.class.new(other)
    end

    protected def underlying : Underlying
      @underlying
    end

    protected def underlying=(@underlying : Underlying)
    end
  end
end
