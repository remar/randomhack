Test: Test.mxml
	flexcompile.py /opt/flex/bin/fcsh \
	mxmlc -static-link-runtime-shared-libraries \
	-library-path+=../lib/flexunit-4.1.0-8-as3_4.1.0.16076.swc \
	-library-path+=../lib/flexunit-uilistener-4.1.0-8-4.1.0.16076.swc \
	-library-path+=../lib/flixel-2.35.swc \
	-source-path+=../src \
	-debug=true \
	Test.mxml

clean:
	rm -rf Test.swf *~
