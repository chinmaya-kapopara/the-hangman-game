my @states = slurp("states").split("\n\n\n");
my $WORD = lines("words".IO).roll;
my %letters_found;
my @alphabets = ('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z');
my $len = 26;
my $count = 1;

&main();
sub main
{	
	shell ('clear');
	say "THE HANGMAN GAME\n"; 	
	say @states[0];
	while @states
	{	
		while 1
		{
			my @guessed_word;
			my $index = 0;
			for $WORD.comb
			{
				if %letters_found{$_} 
				{
					push @guessed_word, $_.uc;
				}
				else 
				{
					push @guessed_word, "_";
				}
			}
			say "\nWord: ", join " ", @guessed_word;
			if none(@guessed_word) eq "_"
			{
				say "\nCongratulations! You guessed it right!\n";
				exit;
			}
			say "\nAvailable letters to choose: ";
			say @alphabets;
			my $letter = prompt "Guess a letter: ";	
			$index++ until (($index eq $len) or (@alphabets[$index] 
                                   eq $letter.uc)); 
			if ($index ne $len)
			{
				splice(@alphabets, $index, 1);
				$len=$len-1;
				if any($WORD.comb).uc eq $letter.uc
				{
					%letters_found{$letter} = True;
					shell ('clear');
					say "THE HANGMAN GAME\n"; 	
					say @states[0];		
				}
				else
				{
					shell ('clear');
					say "THE HANGMAN GAME\n";
					shift @states;
					say @states[0];
					last;
				}
			}	
			else
			{
				say "\nPlease input letter from available choices! 
                        Warning no.$count/3!";
				$count = $count + 1;
				if $count eq 4
				{
					say "Sorry, you are out!";
					exit;
				}
				shell ('sleep 1.5');
				shell ('clear');
				say "THE HANGMAN GAME\n";	
				say @states[0];
			}
		}
	}
	say "\nSorry, you lose :(";
	say "\nThe correct word was '$WORD'.\n";
}
