require "./impl.cr"

module FP
  alias FixedPoint32 = FixedPoint(Int32, 1_000)
  alias FixedPoint64 = FixedPoint(Int64, 1_000_000)

  # Size specific shortcut constructors
  def fp32(val : Number) : FixedPoint32
    FixedPoint32.new val
  end

  def fp64(val : Number) : FixedPoint64
    FixedPoint64.new val
  end

  # Shortcut to create a fixed point using the size of given argument to determine size of fixed point
  def fp(val : Int32) : FixedPoint32
    fp32 val
  end

  def fp(val : Int64) : FixedPoint64
    fp64 val
  end

  def fp(val : Float32) : FixedPoint32
    fp32 val
  end

  def fp(val : Float64) : FixedPoint64
    fp64 val
  end

  # Some helper conversions to fp32 & fp64
  struct FixedPoint(Underlying, Scale) < Number
    def to_fp32 : FixedPoint32
      {% if Underlying.resolve == Int32 %}
        self
      {% else %}
        FixedPoint32.new self.to_f32
      {% end %}
    end

    def to_fp64 : FixedPoint64
      {% if Underlying.resolve == Int64 %}
        self
      {% else %}
        FixedPoint64.new self.to_f
      {% end %}
    end
  end
end
