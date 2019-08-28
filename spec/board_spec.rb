require 'pry'
load 'board.rb'

RSpec.describe Board do
  subject do
    described_class.new(live_cells)
  end

  let(:live_cells) do
    [[1, 8], [2, 8], [2, 10], [3, 8], [3, 9]]
  end

  let(:new_live_cells) do
    [[1, 9], [2, 7], [2, 8], [3, 8], [3, 9]]
  end

  context '#next_generation' do
    before do
      subject.next_generation
    end

    it 'displays the next generation' do
      expect(subject.live_cells).to eq(new_live_cells)
    end
  end
end
