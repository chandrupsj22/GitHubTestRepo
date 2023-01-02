git clone https://rajeshgunait@bitbucket.org/rajeshgunait/javaproject.git
cd javaproject
git remote oringin
git remote add origin https://github.com/rajeshfcgss/sample-test.git
git branch -M master
git push -u origin master




$file ='G:\task2\p2.json'
$contents=Get-content -path $file -Raw | ConvertFrom-Json
$RepoLocation="G:\task2"
foreach ($item in $contents) {
write-host "project" $item.name
$project = $item.name

foreach ($branch in $item.branches) {
write-host "branch" $branch
if($branch -eq "master") {
Set-Location $RepoLocation
if(![System.IO.Directory]::Exists($project)){
write-host [System.IO.Directory]::Exists($project)
New-Item $project -itemType Directory
}
Set-Location $project
write-host [Environment]::CurrentDirectory
git clone https://rajeshgunait@bitbucket.org/rajeshgunait/javaproject.git /$/$project/$branch
Set-Location $branch
cd /$/$project/$branch

git remote remove origin

git remote add origin https://github.com/rajeshfcgss/sample-java.git
git branch -M master
git push -u origin master
}
}
}
