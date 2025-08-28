final emailRegex = RegExp(r'^[^\s@]+@' // local part: 1+ non-space, non-@
    r'(?=.{1,253}$)' // domain total length 1–253
    r'(?:[A-Za-z0-9]' // label must start alnum
    r'(?:[A-Za-z0-9-]{0,61}[A-Za-z0-9])?' // ...may have hyphens in the middle, end alnum, max 63
    r'\.)+' // dot between labels (at least one dot)
    r'[A-Za-z]{2,}$' // final TLD: letters only, length ≥2
    );
