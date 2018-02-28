require 'spec_helper'
require_relative '../../lib/tabletop'

describe Tabletop do
  let(:x) { 2 }
  let(:y) { 2 }
  let(:orientation) { 'W' }
  subject { described_class.new }

  describe "#current_robot_position" do
    context "when the robot has not been placed in the tabletop yet" do
      it 'raises an UnplacedRobotError error' do
        expect { subject.current_robot_position }.to raise_exception(ToyRobot::UnplacedRobotError)
      end
    end

    context "when the robot has been placed in the tabletop" do
      it 'reports the current position of the robot' do
        subject.place(x: x, y: y, orientation: orientation)
        expect(subject.current_robot_position).to eq([x, y, orientation])
      end
    end
  end

  describe "#place" do
    context "when the position is valid" do
      it 'places the robot in the specified position' do
        subject.place(x: x, y: y, orientation: orientation)
        expect(subject.current_robot_position).to eq([x, y, orientation])
      end
    end

    context "when the position is invalid" do
      let(:y) { 43 }

      it 'raises an InvalidPlacement error' do
        expect { subject.place(x: x, y: y, orientation: orientation) }
          .to raise_exception(ToyRobot::InvalidPlacement)
      end
    end
  end
end
