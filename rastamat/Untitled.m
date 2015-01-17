 % Convert to MFCCs very close to those genrated by feacalc -sr 22050 -nyq 8000 -dith -hpf -opf htk -delta 0 -plp no -dom cep -com yes -frq mel -filt tri -win 32 -step 16 -cep 20
 [mm,aspc] = melfcc(f, fs, 'maxfreq', 500,'minfreq',0);
 % .. then convert the cepstra back to audio (same options)
 [im,ispc] = invmelfcc(mm, fs, 'maxfreq', 500,'minfreq',0);
 % listen to the reconstruction
 soundsc(im,fs)
 % compare the spectrograms
 subplot(311)
 specgram(f,512,fs)
 caxis([-50 30])
 title('original music')
 subplot(312)
 specgram(im,512,fs)
 caxis([-40 40])
 title('noise-excited reconstruction from cepstra')
 % Notice how spectral detail is blurred out e.g. the triangle hits around 6 kHz are broadened to a noise bank from 6-8 kHz.
 % save out the reconstruction
 max(abs(im))