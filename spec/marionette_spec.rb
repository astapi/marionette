require 'spec_helper'

describe Marionette do
  context 'version' do
    it 'has a version number' do
      expect(Marionette::VERSION).not_to be '0.1.0'
    end
  end

  context 'Marionette::Aws::Task' do
    let!(:task) { Marionette::Aws::Task.new }

    describe 'update_task' do
      it do
        #task.update_task('front_app')
      end
    end
  end
end
