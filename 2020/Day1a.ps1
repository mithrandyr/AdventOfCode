[cmdletBinding()]
param([parameter(ValueFromPipeline)][int[]]$data)

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
    $searchCount = 0
    $arrayLocation = 0    
    $searchLocation = 1
    while($true -or $arrayLocation -eq $dataList.Count) {
        write-host "." -NoNewline
        $searchCount += 1
        #Write-Host ("Iteration #{0} --> {1}: {2} AND {3}: {4}" -f $searchCount, $arrayLocation, $dataList[$arrayLocation], $searchLocation, $dataList[$searchLocation])
        if($dataList[$arrayLocation] + $dataList[$searchLocation] -eq 2020) {
            Write-Host
            Write-Verbose ("Took {0} iterations, solution found at {1}: {2} AND {3}: {4}" -f $searchCount, $arrayLocation, $dataList[$arrayLocation], $searchLocation, $dataList[$searchLocation])
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