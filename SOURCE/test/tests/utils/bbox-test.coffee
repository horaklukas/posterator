describe 'Class BBox', ->
  BBox = null

  beforeAll ->
    BBox = require '../../../public/scripts/utils/bbox'
    @bb = new BBox 15, 20, 30, 17
    @bbr = new BBox 150, 170, 84, 20, 30

  describe 'constructor', ->
    it 'should create bbox points from supplied data without rotation', ->
      expect(@bb.tl, 'Top left').toEqual {x: 15, y: 20}
      expect(@bb.tr, 'Top right').toEqual {x: 45, y: 20}
      expect(@bb.bl, 'Bottom left').toEqual {x: 15, y: 37}
      expect(@bb.br, 'Bottom right').toEqual {x: 45, y: 37}

    it 'should create bbox points from supplied data with rotation', ->
      expect(@bbr.tl, 'Top left').toEqual {x: 150, y: 170}
      expect(@bbr.tr, 'Top right').toEqual {x: 223, y: 212}
      expect(@bbr.bl, 'Bottom left').toEqual {x: 140, y: 187}
      expect(@bbr.br, 'Bottom right').toEqual {x: 213, y: 229}

  describe 'method contains', ->
    describe 'without rotation', ->
      it 'should return false when point is inside the box on x but not y axis', ->
        expect(@bb.contains 28, 96).toBe.false

      it 'should return false when point is inside the box on y but not x axis', ->
        expect(@bb.contains 13, 63).toBe.false

      it 'should return true when point is inside the box on both axis', ->
        expect(@bb.contains 32, 33).toBe.true

    describe 'with rotation', ->
      it 'should return false when point isnt inside the box', ->
        expect(@bbr.contains 166, 210).toBe.false

      it 'should return true when point is inside the box', ->
        expect(@bbr.contains 182, 201).toBe.true