class Errable
  private

  def new_err
    @err = FFI::MemoryPointer.new(:pointer)
    @err.write_pointer FFI::MemoryPointer.from_string("")
  end

  def check_err
    err_msg = @err.read_pointer.read_string
    unless err_msg == ''
      throw :libuplink_error, err_msg
    end
  end
end
