## Bed Format for ORM file
Each entry is a Fiber
- 1st column:
    chromsome
- 2nd column:
    start
- 3nd column:
    end
- 4th column:
    Fiber name (Uniq Id)
- 5th column:
    Fiber Score (default 0 , compatible with BED6 )
- 6th column:
    Fiber Strand (default . , compatible with BED6 )
- 7th column:
    Feature Number
- 8th column:
    Fiber Features:
        N represents Nucleotide,
        S represents Segment,
    Example:
        N,N,S,N
- 9th column:
    Fiber Feature Positions (relative to start)
- 10th column:
    Fiber Feature Values
        Nucleotide: fluorescence intenstiy (0-2000)
        Segment:    segment size
