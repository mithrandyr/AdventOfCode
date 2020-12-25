[cmdletBinding()]
param([parameter(ValueFromPipeline)][int[]]$data, [ValidateSet("BruteForce","Intelligence")][string]$method = "Intelligence")

<#
Before you leave, the Elves in accounting just need you to fix your expense report (your puzzle input); apparently, something isn't quite adding up.
Specifically, they need you to find the two entries that sum to 2020 and then multiply those two numbers together.

For example, suppose your expense report contained the following:
1721
979
366
299
675
1456

In this list, the two entries that sum to 2020 are 1721 and 299. Multiplying them together produces 1721 * 299 = 514579, so the correct answer is 514579.
#>
begin { $dataList = [int[]]@() }
process{ $dataList += $data }
end {
    <# -- Second Attempt: intelligence?
        Was considering sorting the list and adding the biggest to smallest.. but then it hit me... I should only have to iterate through the list once...
        calculating the required value each time, then search for that in the list.
    #>
    if($method -eq "Intelligence") {
        $sw = [System.Diagnostics.Stopwatch]::StartNew()
        $DiffList = @()
        $searchCount = 0
        foreach($d in $dataList) {
            $searchCount += 1
            $diff = 2020 - $d
            if($DiffList.Contains($d)) {
                Write-Host ("Time: {0}ms | Iterations: {1}" -f $sw.Elapsed.TotalMilliseconds, $searchCount)
                $sw.stop()
                $sw = $null
                return $diff * $d
            }
            else { $DiffList += $diff }         
        }
    }

    if($method -eq "BruteForce"){
        $sw = [System.Diagnostics.Stopwatch]::StartNew()
        $searchCount = 0
        $arrayLocation = 0    
        $searchLocation = 1
        while($true -or $arrayLocation -eq $dataList.Count) {
            #write-host "." -NoNewline
            $searchCount += 1
            #Write-Host ("Iteration #{0} --> {1}: {2} AND {3}: {4}" -f $searchCount, $arrayLocation, $dataList[$arrayLocation], $searchLocation, $dataList[$searchLocation])
            if($dataList[$arrayLocation] + $dataList[$searchLocation] -eq 2020) {
                Write-Host ("Time: {0}ms | Iterations: {1}" -f $sw.Elapsed.TotalMilliseconds, $searchCount)
                $sw.stop()
                $sw = $null
                return $dataList[$arrayLocation] * $dataList[$searchLocation]
            }
            else {
                $searchLocation += 1
                if($searchLocation -eq $dataList.Count) {
                    $arrayLocation += 1
                    $searchLocation = $arrayLocation
                }
            }
        }
    }

}