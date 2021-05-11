#tag Module
Protected Module GURBScript
	#tag Method, Flags = &h0
		Function RBScriptErrorCodeToString(errorCode as integer) As string
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim errorString as string
		  
		  ' Look up the error code and covert it to a string.
		  select case errorCode
		    
		  case 1
		    errorString = "Syntax does not make sense."
		    
		  case 2
		    errorString = "Type mismatch."
		    
		  case 3
		    errorString = "Select Case does not support that type of expression."
		    
		  case 4
		    errorString = "The compiler is not implemented (obsolete)."
		    
		  case 5
		    errorString = "The parser's internal stack has overflowed."
		    
		  case 6
		    errorString = "Too many parameters for this function."
		    
		  case 7
		    errorString = "Not enough parameters for this function call."
		    
		  case 8
		    errorString = "Wrong number of parameters for this function call."
		    
		  case 9
		    errorString = "Parameters are incompatible with this function."
		    
		  case 10
		    errorString = "Assignment of an incompatible data type."
		    
		  case 11
		    errorString = "Undefined identifier."
		    
		  case 12
		    errorString = "Undefined operator."
		    
		  case 13
		    errorString = "Logic operations require Boolean operands."
		    
		  case 14
		    errorString = "Array bounds must be integers."
		    
		  case 15
		    errorString = "Can't call a non-function."
		    
		  case 16
		    errorString = "Can't get an element from something that isn't an array."
		    
		  case 17
		    errorString = "Not enough subscripts for this array’s dimensions."
		    
		  case 18
		    errorString = "Too many subscripts for this array’s dimensions."
		    
		  case 19
		    errorString = "Can't assign an entire array."
		    
		  case 20
		    errorString = "Can't use an entire array in an expression."
		    
		  case 21
		    errorString = "Can't pass an expression as a ByRef parameter."
		    
		  case 22
		    errorString = "Duplicate identifier."
		    
		  case 23
		    errorString = "The backend code generator failed."
		    
		  case 24
		    errorString = "Ambiguous call to overloaded method."
		    
		  case 25
		    errorString = "Multiple inheritance is not allowed."
		    
		  case 26
		    errorString = "Cannot create an instance of an interface."
		    
		  case 27
		    errorString = "Cannot implement a class as though it were an interface."
		    
		  case 28
		    errorString = "Cannot inherit from something that is not a class."
		    
		  case 29
		    errorString = "This class does not fully implement the specified interface."
		    
		  case 30
		    errorString = "Event handlers cannot live outside of a class."
		    
		  case 31
		    errorString = "It is not legal to ignore the result of a function call."
		    
		  case 32
		    errorString = "Can’t use “Self” keyword outside of a class."
		    
		  case 33
		    errorString = "Can’t use “Me” keyword outside of a class."
		    
		  case 34
		    errorString = "Can’t return a value from a Sub."
		    
		  case 35
		    errorString = "An exception object required here."
		    
		  case 40
		    errorString = "Destructors can’t have parameters."
		    
		  case 41
		    errorString = "Can’t use “Super” keyword outside of a class."
		    
		  case 42
		    errorString = "Can’t use “Super” keyword in a class that has no parent."
		    
		  else
		    
		    errorString = "Unknown error."
		    
		  end select
		  
		  ' Return the error as a string.
		  return errorString
		  
		End Function
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="Object"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
