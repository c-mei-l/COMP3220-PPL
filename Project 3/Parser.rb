# https://www.cs.rochester.edu/~brown/173/readings/05_grammars.txt
#
#  "TINY" Grammar
#
# PGM        -->   STMT+
# STMT       -->   ASSIGN   |   "print"  EXP
# ASSIGN     -->   ID  "="  EXP
# EXP        -->   TERM   ETAIL
# ETAIL      -->   "+" TERM   ETAIL  | "-" TERM   ETAIL | EPSILON
# TERM       -->   FACTOR  TTAIL
# TTAIL      -->   "*" FACTOR TTAIL  | "/" FACTOR TTAIL | EPSILON
# FACTOR     -->   "(" EXP ")" | INT | ID
# ID         -->   ALPHA+
# ALPHA      -->   a  |  b  | … | z  or
#                  A  |  B  | … | Z
# INT        -->   DIGIT+
# DIGIT      -->   0  |  1  | …  |  9
# WHITESPACE -->   Ruby Whitespace

#
#  Parser Class
#
load "Token.rb"
load "Lexer.rb"
$errorCount = 0
class Parser < Scanner
	def initialize(filename)
    	super(filename)
    	consume()
   	end

	def consume()
      	@lookAhead = nextToken()
      	while(@lookAhead.type == Token::WS)
        	@lookAhead = nextToken()
      	end
   	end

	def match(*dtype)
      	if (@lookAhead.type != dtype)
					if (dtype.length() > 1)
						dtype.map!(&:upcase)
					end
         	puts "Expected #{dtype.join(" or ")} found #{@lookAhead.text}"
					$errorCount += 1
      	end
      	consume()
   	end

		def program()
      	while( @lookAhead.type != Token::EOF)
        	puts "Entering STMT Rule"
			statement()
			end
			puts "There were #{$errorCount} parse errors found."
		end


		def exp()
			puts "Entering TERM Rule"
			term()

			puts "Entering ETAIL Rule"
			etail()

			puts "Exiting EXP Rule"
			rparen()
		end


		def rparen()
			if (@lookAhead.type == Token::RPAREN)
				puts "Found RPAREN Token: #{@lookAhead.text}"
				match(Token::RPAREN)
			end
		end


		def assign()
			id()
			if (@lookAhead.type == Token::ASSGN)
				puts "Found ASSGN Token: ="
			end

			match (Token::ASSGN)
			puts "Entering EXP Rule"
			exp()
			puts "Exiting ASSGN Rule"
		end


		def id()
			if(@lookAhead.type == Token::ID)
				puts "Found ID Token: #{@lookAhead.text}"
			end
			match (Token::ID)
		end


		def term()
			puts "Entering FACTOR Rule"
			factor()
			puts "Entering TTAIL Rule"
			ttail()
	    puts "Exiting TERM Rule"
		end


		def factor()
			if (@lookAhead.type == Token::LPAREN)
				puts "Found LPAREN Token: #{@lookAhead.text}"
				match(Token::LPAREN)
				puts "Entering EXP Rule"
				exp()
			elsif (@lookAhead.type == Token::INT)
				int()
			elsif (@lookAhead.type == Token::ID)
				id()
			else
				match(Token::LPAREN, Token::INT, Token::ID)
			end
			puts "Exiting FACTOR Rule"
		end


		def int()
			if (@lookAhead.type == Token::INT)
				puts "Found INT Token: #{@lookAhead.text}"
				match(Token::INT)
			end

		end


		def etail()
			if (@lookAhead.type == Token:: ADDOP)
				puts "Found ADDOP Token: #{@lookAhead.text}"
				match (Token::ADDOP)
				puts "Entering TERM Rule"
				term()
				puts "Entering ETAIL Rule"
				etail()
			elsif (@lookAhead.type == Token::SUBOP)
				puts "Found SUBOP Token :#{@lookAhead.text}"
				match(Toekn::SUBOP)
				puts "Entering TERM Rule"
				term()
				puts "Entering ETAIL Rule"
				etail()
			elsif (@lookAhead.type != Token::ADDOP or @lookAhead.type != Token::SUBOP)
				puts "Did not find ADDOP or SUBOP Token, choosing EPSILON production"
			end
			puts "Exiting ETAIL Rule"
		end


		def ttail()
			if(@lookAhead.type == Token:: MULTOP)
				puts "Found MULTOP Token: #{@lookAhead.text}"
				match (Token::MULTOP)
				puts "Entering FACTOR Rule"
				factor()
				puts "Entering TTAIL Rule"
				ttail()

			elsif (@lookAhead.type == Token::DIVOP)
				puts "Found DIVOP Token: #{@lookAhead.text}"
				match (Token::DIVOP)
				puts "Entering FACTOR Rule"
				factor()
				puts "Entering TTAIL Rule"
				ttail()

			elsif (@lookAhead.type != Token::MULTOP or @lookAhead.type != Token::DIVOP)
				puts "Did not find MULTOP or DIVOP Token, choosing EPSILON production"
			end
			puts "Exiting TTAIL Rule"
		end


		def statement()
			if (@lookAhead.type == Token::PRINT)
				puts "Found PRINT Token: #{@lookAhead.text}"
				match(Token::PRINT)
				puts "Entering EXP Rule"
				exp()
			else
				puts "Entering ASSGN Rule"
				assign()
			end

			puts "Exiting STMT Rule"
		end
	end
