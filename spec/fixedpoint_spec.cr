require "./spec_helper"

describe FixedPoint do
  describe "#initialize" do
    it "can construct from float32" do
      fp(13.37f32).should eq(13.37f32)
    end

    it "can construct from int32" do
      fp(1337i32).should eq(1337i32)
    end

    it "can construct from float64" do
      fp(13.37f64).should eq(13.37f64)
    end

    it "can construct from int64" do
      fp(1337i64).should eq(1337i64)
    end
  end

  describe "#-" do
    it { (-fp(11)).should eq(-11) }
  end

  describe "#+ with fixed point" do
    it { (fp(123) + fp(456)).should eq(579) }
    it { (fp(999) + fp(-1)).should eq(998) }
    it { (fp(123.456) + fp(3.3)).should eq(126.756) }
  end

  describe "#- with fixed point" do
    it { (fp(123) - fp(456)).should eq(-333) }
    it { (fp(999) - fp(-1)).should eq(1000) }
    it { (fp(123.456) - fp(3.3)).should eq(120.156) }
  end

  describe "#* with fixed point" do
    it { (fp(11) * fp(5)).should eq(55) }
    it { (fp(11.11) * fp(11.11)).should eq(123.4321) }
    it { (fp(11.11) * fp64(10)).should eq(111.1) }
  end

  describe "#/ with fixed point" do
    it { (fp(11) / fp(5)).should eq(2.2) }
    it { (fp(12345) / fp(67)).should eq(184.253731) }
    it { (fp(123.456) / fp(3.3)).should eq(37.410909) }
  end

  describe "#% with fixed point" do
    it { (fp(11) % fp(2)).should eq(1) }
    it { (fp(11.5) % fp64(4)).should eq(3.5) }
    it { (fp(-11.5) % fp64(4)).should eq(0.5) }
  end

  describe "#** with fixed point" do
    it { (fp32(2.5) ** fp32(2)).should eq(6.25) }
    it { (fp32(2.5) ** fp32(2.5)).should eq(9.882) }
    it { (fp64(2.5) ** fp64(2)).should eq(6.25) }
    it { (fp64(2.5) ** fp64(2.5)).should eq(9.882117) }
  end

  describe "#modulo with fixed point" do
    it "raises when modulo by zero" do
      expect_raises(DivisionByZeroError) { fp(1.2).modulo fp(0.0) }
    end

    it { (fp(13).modulo fp(4)).should eq(1) }
    it { (fp(13).modulo fp(-4)).should eq(-3) }
    it { (fp(-13).modulo fp(4)).should eq(3) }
    it { (fp(-13).modulo fp(-4)).should eq(-1) }
    it { (fp(11.5).modulo fp64(4)).should eq(3.5) }
    it { (fp(11.5).modulo fp64(-4)).should eq(-0.5) }
    it { (fp(-11.5).modulo fp64(4)).should eq(0.5) }
    it { (fp(-11.5).modulo fp64(-4)).should eq(-3.5) }
  end

  describe "#remainder with fixed point" do
    it "raises when modulo by zero" do
      expect_raises(DivisionByZeroError) { fp(1.2).remainder fp(0.0) }
    end

    it { (fp(13).remainder fp(4)).should eq(1) }
    it { (fp(13).remainder fp(-4)).should eq(1) }
    it { (fp(-13).remainder fp(4)).should eq(-1) }
    it { (fp(-13).remainder fp(-4)).should eq(-1) }
    it { (fp(11.5).remainder fp64(4)).should eq(3.5) }
    it { (fp(11.5).remainder fp64(-4)).should eq(3.5) }
    it { (fp(-11.5).remainder fp64(4)).should eq(-3.5) }
    it { (fp(-11.5).remainder fp64(-4)).should eq(-3.5) }
  end

  describe "#round" do
    it { fp(2.5).round.should eq(2) }
    it { fp(2.6).round.should eq(3) }
    it { fp(3.5).round.should eq(4) }
  end

  describe "#floor" do
    it { fp(2.1).floor.should eq(2) }
    it { fp(3.9).floor.should eq(3) }
  end

  describe "#ceil" do
    it { fp(2.0).ceil.should eq(2) }
    it { fp(3.1).ceil.should eq(4) }
    it { fp(4.9).ceil.should eq(5) }
  end

  describe "#inspect" do
    it { fp(3.2).inspect.should eq("3.2") }
  end

  describe "#to_s" do
    it { fp(12.34).to_s.should eq("12.34") }
    it { fp(1.2).to_s.should eq("1.2") }
    it { fp(1.23).to_s.should eq("1.23") }
    it { fp(0.65000000000000002).to_s.should eq("0.65") }
    it { fp(1.23499).to_s.should eq("1.23499") }
    it { fp(1.23399999999999999).to_s.should eq("1.234") }
    it { fp(12.9999999999999999).to_s.should eq("13.0") }
  end

  describe "#to_f" do
    it { fp(12.34).to_f.should eq(12.34) }
    it { fp(1.2).to_f.should eq(1.2) }
    it { fp(0.65000000000000002).to_f.should eq(0.65000000000000002) }
  end

  describe "#to_i" do
    it { fp(12.34).to_i.should eq(12) }
    it { fp(1.2).to_i.should eq(1) }
    it { fp(0.65000000000000002).to_i.should eq(0) }
  end
end
