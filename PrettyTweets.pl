# vim keybinding for running this extension during testing
# yank the lines and execute them with :@" separately
# :nmap <F5> :w<CR>:!ttytter -timestamp="\%H:\%M" -exts=%:p<CR>
# :imap <F5> <Esc>:w<CR>:!ttytter -timestamp="\%H:\%M" -exts=%:p<CR>

$handle = sub {
	my $ref = shift;

	$color = ${'CC'.scalar(&$tweettype($ref,&descape($ref->{'user'}->{'screen_name'}),$ref->{'text'}))};
	$color = $OFF.$color;

	my ($time, $ts) = &$wraptime($ref->{'created_at'}) if &getvariable('timestamp');
	my $menuselect = '<'.$ref->{'menu_select'}.'> ';
	my $timestamp = defined($ts)?'['.$ts.'] ':'';
	my $names;
	if (defined $ref->{'user'}->{'name'}) {
		$names = 
			"${EM}".
			&descape($ref->{'user'}->{'name'}).
			"$OFF".
			' (http://twitter.com/'.
			"${EM}".
			&descape($ref->{'user'}->{'screen_name'}).
			"$OFF".
			') '
		;
	} else {
		$names = "${EM}".&descape($ref->{'user'}->{'screen_name'})."$OFF ";
	}
	my $text = "${color}".&descape($ref->{'text'})."$OFF";

	print $streamout (
		"${color}".$menuselect."$OFF",
		$timestamp,
		$names,
		"\n",
		(' ' x length $menuselect),
		$text,
		"\n",
	);
	return 1;
};

$dmhandle = sub {
	my $ref = shift;

	$color = ${'CCdm'};
	$color = $OFF.$color;

	my ($time, $ts) = &$wraptime($ref->{'created_at'}) if &getvariable('timestamp');
	my $menuselect = '<DM d'.$ref->{'menu_select'}.'> ';
	my $timestamp = defined($ts)?'['.$ts.'] ':'';
	my $names;
	if (defined $ref->{'sender'}->{'name'}) {
		$names = 
			"${EM}".
			&descape($ref->{'sender'}->{'name'}).
			"$OFF".
			' (http://twitter.com/'.
			"${EM}".
			&descape($ref->{'sender'}->{'screen_name'}).
			"$OFF".
			') '
		;
	} else {
		$names = "${EM}".&descape($ref->{'sender'}->{'screen_name'})."$OFF ";
	}
	my $text = "${color}".&descape($ref->{'text'})."$OFF";

	print $streamout (
		"${color}".$menuselect."$OFF",
		$timestamp,
		$names,
		"\n",
		(' ' x length $menuselect),
		$text,
		"\n",
	);
	return 1;
};
