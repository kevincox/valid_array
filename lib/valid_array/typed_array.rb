# :include: ../README.rdoc

require 'set'
require 'valid_array'

# Provides ValidArray functionality to a subclass of Array
# when extended in the class's definiton
module ValidArray::TypedArray
  # when a class inherits from this one, make sure that it also inherits
  # the types that are being enforced
  def inherited(subclass)
    self._subclasses << subclass
    subclass.restricted_types *self.restricted_types
  end
  
  # A getter/setter for types to add. If no arguments are passed, it simply
  # returns the current array of accepted types.
  def restricted_types(*types)
    @_restricted_types ||= []
    types.each do |type|
      raise UnexpectedTypeException.new([Class],type.class) unless type.is_a? Class
      @_restricted_types << type unless @_restricted_types.include? type
      _subclasses.each do |subclass|
        subclass.restricted_types type
      end
    end
    @_restricted_types
  end; alias :restricted_type :restricted_types
  
  
  # The exception that is raised when an Unexpected Type is reached during validation
  class UnexpectedTypeException < Exception
    # Provide access to the types of objects expected and the class of the object received
    attr_reader :expected, :received

    def initialize(expected_one_of, received)
      @expected = expected_one_of
      @received = received
    end

    def to_s
      %{Expected one of #{@expected.inspect} but received a(n) #{@received}}
    end
  end

  def validate(item)
    if item.nil? or restricted_types.any? { |allowed| item.class <= allowed }
      return item
    else
      raise TypedArray::UnexpectedTypeException.new(restricted_types, item.class)
    end
  end
  
  protected

  # a store of subclasses
  def _subclasses
    @_subclasses ||= []
  end

end

# Provide a factory method. Takes any number of types to accept as arguments
# and returns a class that behaves as a type-enforced array.
def ValidArray::TypedArray(*types_allowed)
  klass = Class.new( Array )
  klass.class_exec(types_allowed) do |types_allowed|
    extend ValidArray
    extend TypedArray
    
    restricted_types *types_allowed
  end
  klass
end
