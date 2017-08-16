class REPL
  class Command
    include ::Keystone

    AsmSyntaxError = Class.new(SyntaxError)

    def initialize(value)
      @assembler = Ks.new(KS_ARCH_X86, KS_MODE_32)
      @encoding  = nil
      @value     = value
    end
    attr_reader :value, :encoding

    def execute
      @encoding, _ = @assembler.asm(@value)
    rescue Keystone::KsError
      raise AsmSyntaxError
    end
  end
end
