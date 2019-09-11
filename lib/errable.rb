class Errable
  attr_reader :err

  def initialize
    new_err
  end

  def check_err
    err_msg = @err.read_pointer.read_string
    unless err_msg == ''
      raise LibUplink::Error, err_msg
    end
  end

  private

  def new_err
    @err = FFI::MemoryPointer.new(:pointer)
    @err.write_pointer(FFI::MemoryPointer.from_string(""))
  end
end
