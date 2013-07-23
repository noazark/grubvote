require "key_generator"

describe KeyGenerator do
  describe '#generates' do
    it 'returns a key' do
      KeyGenerator.generate.should_not be_nil
    end

    it 'creates a lowercase alpha numeric string by default' do
      key = KeyGenerator.generate 360
      key.should match(/^[a-z0-9]+$/)
    end

    it 'optionally can accept a character map' do
      key = KeyGenerator.generate 40, '!@#$'
      key.should match(/^[\!\@\#\$]+$/)
    end

    it 'creates a 6 character long string by default' do
      key = KeyGenerator.generate
      key.length.should eq 6
    end

    it 'can generate arbitrary length strings' do
      length = rand(0..100)
      key = KeyGenerator.generate length
      key.length.should eq length
    end

    it 'returns a uniquely random key' do
      keys = []
      10.times do
        keys << KeyGenerator.generate
      end
      keys.uniq.count.should eq 10
    end
  end
end