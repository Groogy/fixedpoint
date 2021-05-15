struct Float < Number
  def +(other : FixedPoint(U, S)) : FixedPoint forall U, S
    FixedPoint(U, S).new(self) + other
  end

  def -(other : FixedPoint(U, S)) : FixedPoint forall U, S
    FixedPoint(U, S).new(self) - other
  end

  def *(other : FixedPoint(U, S)) : FixedPoint forall U, S
    FixedPoint(U, S).new(self) * other
  end

  def /(other : FixedPoint(U, S)) : FixedPoint forall U, S
    FixedPoint(U, S).new(self) / other
  end
end

struct Int < Number
  def +(other : FixedPoint(U, S)) : FixedPoint forall U, S
    FixedPoint(U, S).new(self) + other
  end

  def -(other : FixedPoint(U, S)) : FixedPoint forall U, S
    FixedPoint(U, S).new(self) - other
  end

  def *(other : FixedPoint(U, S)) : FixedPoint forall U, S
    FixedPoint(U, S).new(self) * other
  end

  def /(other : FixedPoint(U, S)) : FixedPoint forall U, S
    FixedPoint(U, S).new(self) / other
  end
end
