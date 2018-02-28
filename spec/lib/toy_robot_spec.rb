require 'spec_helper'
require_relative '../../lib/toy_robot'
require_relative '../../lib/tabletop'

describe ToyRobot do
  subject { ToyRobot.new }

  describe "#left" do
    it "turns the robot to the left" do
      subject.place(x: 0, y: 0, orientation: 'N')
      subject.left
      expect(subject.report).to eq([0, 0, 'W'])

      subject.left
      expect(subject.report).to eq([0, 0, 'S'])

      subject.left
      expect(subject.report).to eq([0, 0, 'E'])

      subject.left
      expect(subject.report).to eq([0, 0, 'N'])
    end
  end

  describe "#right" do
    it "turns the robot to the right" do
      subject.place(x: 0, y: 0, orientation: 'N')
      subject.right
      expect(subject.report).to eq([0, 0, 'E'])

      subject.right
      expect(subject.report).to eq([0, 0, 'S'])

      subject.right
      expect(subject.report).to eq([0, 0, 'W'])

      subject.right
      expect(subject.report).to eq([0, 0, 'N'])
    end
  end

  describe "#move" do
    context "when the move is to a position within boundaries" do
      context "when the robot orientation is north" do
        it "moves the robot" do
          subject.place(x: 0, y: 0, orientation: 'N')
          subject.move
          expect(subject.report).to eq([0, 1, 'N'])
        end
      end

      context "when the robot orientation is south" do
        it "moves the robot" do
          subject.place(x: 0, y: 1, orientation: 'S')
          subject.move
          expect(subject.report).to eq([0, 0, 'S'])
        end
      end

      context "when the robot orientation is east" do
        it "moves the robot" do
          subject.place(x: 0, y: 0, orientation: 'E')
          subject.move
          expect(subject.report).to eq([1, 0, 'E'])
        end
      end

      context "when the robot orientation is west" do
        it "moves the robot" do
          subject.place(x: 1, y: 0, orientation: 'W')
          subject.move
          expect(subject.report).to eq([0, 0, 'W'])
        end
      end
    end

    context "when the move is to a position beyond boundaries" do
      it "ignores the command" do
        subject.place(x: 0, y: 0, orientation: 'S')
        subject.move
        expect(subject.report).to eq([0, 0, 'S'])
      end
    end
  end

  describe "#report" do
    context "when the robot has been placed in the tabletop" do
      it "returns an array with the position and orientation" do
        subject.place(x: 4, y: 4, orientation: 'W')
        expect(subject.report).to eq([4, 4, 'W'])
      end
    end

    context "when the robot has NOT been placed in the tabletop" do
      it "raises a UnplacedRobotError exception" do
        expect { subject.report }.to raise_exception(Tabletop::UnplacedRobotError)
      end
    end
  end

  describe "#place" do
    context "when the placement is within boundaries" do
      it "places the robot somewhere in the tabletop" do
        subject.place(x: 4, y: 4, orientation: 'W')
        expect(subject.report).to eq([4, 4, 'W'])
      end
    end

    context "when the placement is outside boundaries" do
      it "raises an InvalidPlacement exception" do
        expect { subject.place(x: 999, y: 4, orientation: 'W') }
          .to raise_exception(Tabletop::InvalidPlacement)
      end
    end
  end
end
