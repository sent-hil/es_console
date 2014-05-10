require_relative 'spec_helper'

describe EsConsole do
  it 'starts console' do
    EsConsole::Console.any_instance.should_receive(:pry)
    EsConsole::Console.start
  end
end
