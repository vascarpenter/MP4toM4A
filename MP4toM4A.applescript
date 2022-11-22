on open inItems
	with timeout of (1 * 60 * 60 * 12) seconds
		repeat with tgtItem in inItems
			tell application "Finder"
				set tgtItem to tgtItem as alias
				zipIt(tgtItem) of me
			end tell
		end repeat
	end timeout
end open


on zipIt(tgtItem)
	set thisFldr to (path to me as alias) as string
	set thisFldr to POSIX path of thisFldr
	--パス内に空白文字が含まれていた場合の対策
	set thisFldr to (ASCII character (34)) & thisFldr & (ASCII character (34))
	--scriptのパスを合成
	set shellScriptExecpath to thisFldr & "Contents/Resources/convertmp4.sh"
	
	tell application "Finder"
		set tgtName to name of tgtItem as Unicode text
		set tgtNameQ to quoted form of tgtName
		
		set tgtParent to parent of tgtItem as alias
		set tgtParentQ to quoted form of POSIX path of tgtParent
    
		do shell script "cd " & tgtParentQ & " ; " & shellScriptExecpath & " " & tgtNameQ
		
	end tell
end zipIt
