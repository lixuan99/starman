class Bufrlib < Package
  url 'http://www.nco.ncep.noaa.gov/sib/decoders/BUFRLIB/BUFRLIB_v11-0-0.tar'
  sha256 'f8828216f1d523aae5cc34151153577dc8cead61b3df7b074f936776ec0069df'
  version '11.0.0'

  def install
    if CompilerSet.fortran.gcc?
      flags = '-fno-underscoring'
      inreplace 'preproc.sh', {
        '-C' => '',
        'cpp' => 'cpp -traditional-cpp'
      }
    elsif CompilerSet.fortran.intel?
      flags = '-assume nounderscore'
    else
      flags = ''
    end
    inreplace 'preproc.sh', 'cpp', 'fpp' if CompilerSet.fortran.intel?
    run '$CC -c `./preproc.sh` *.c'
    run '$FC ', flags, ' -c modv*.f moda*.f `ls -1 *.f | grep -v "mod[av]_"`'
    run 'ar crv libbufr.a *.o'
    mkdir inc
    mkdir lib
    mv '*.h', inc
    mv 'libbufr.a', lib
  end
end
