describe 'Class BBox', ->
  BBox = null

  before ->
    BBox = require '../../../public/scripts/utils/bbox'
    @bb = new BBox 15, 20, 30, 17
    @bbr = new BBox 150, 170, 84, 20, 30

  describe 'constructor', ->
    it 'should create bbox points from supplied data without rotation', ->
      expect(@bb, 'Top left').to.have.property('tl').that.eql {x: 15, y: 20}
      expect(@bb, 'Top right').to.have.property('tr').that.eql {x: 45, y: 20}
      expect(@bb, 'Bottom left').to.have.property('bl').that.eql {x: 15, y: 37}
      expect(@bb, 'Bottom right').to.have.property('br').that.eql {x: 45, y: 37}

    it 'should create bbox points from supplied data with rotation', ->
      expect(@bbr, 'Top left').to.have.property('tl').that.eql {x: 150, y: 170}
      expect(@bbr, 'Top right').to.have.property('tr').that.eql {x: 223, y: 212}
      expect(@bbr, 'Bottom left').to.have.property('bl').that.eql {x: 140, y: 187}
      expect(@bbr, 'Bottom right').to.have.property('br').that.eql {x: 213, y: 229}

  describe 'method contains', ->
    describe 'without rotation', ->
      it 'should return false when point is inside the box on x but not y axis', ->
        expect(@bb.contains 28, 96).to.be.false

      it 'should return false when point is inside the box on y but not x axis', ->
        expect(@bb.contains 13, 63).to.be.false

      it 'should return true when point is inside the box on both axis', ->
        expect(@bb.contains 32, 33).to.be.true

    describe 'with rotation', ->
      it 'should return false when point isnt inside the box', ->
        expect(@bbr.contains 166, 210).to.be.false

      it 'should return true when point is inside the box', ->
        expect(@bbr.contains 182, 201).to.be.true