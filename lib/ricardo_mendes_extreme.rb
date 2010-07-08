module TextEditor
  class Document

    def initialize
      @op_stack   = Array.new 0
      @undo_stack = Array.new 0
    end


    def stash(command)
      @op_stack.push command
      @undo_stack.clear
    end

    def add_text(text, position=-1)
      stash [:insert, position, text]
    end

    def remove_text(first=0, last=contents.length)
      stash [:slice!, (first...last)]
    end


    def undo
      @undo_stack << @op_stack.pop unless @op_stack.empty?
    end

    def redo
      @op_stack << @undo_stack.pop unless @undo_stack.empty?
    end


    def contents
      @op_stack.reduce('') {|contents,op| contents.send(*op); contents }
    end

  end
end
