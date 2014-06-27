image:
	docker build --rm -t goern/rhel6candlepin . |& tee dockerbuild.log

dist:
	(cd ..;tar cvf dist.tar candlepin-rhel6/container-etc  candlepin-rhel6/Dockerfile  candlepin-rhel6/Makefile) 

deploy:
	gear deploy candlepin_gear_deploy.json

clean:
	rm candlepin_gear_deploy.json.*
