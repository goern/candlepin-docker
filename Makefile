container:
	docker build -rm -t goern/rhel_candlepin . |& tee dockerbuild.log

dist:
	(cd ..;tar cvf dist.tar candlepin-rhel6/container-etc  candlepin-rhel6/Dockerfile  candlepin-rhel6/Makefile) 
