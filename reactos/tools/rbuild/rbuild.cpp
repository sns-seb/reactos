// rbuild.cpp

#include "pch.h"

#include <stdio.h>
#include <io.h>
#include <assert.h>

#include "rbuild.h"

using std::string;
using std::vector;

int
main ( int argc, char** argv )
{
	try
	{
		string projectFilename ( "ReactOS.xml" );
		Project* project = new Project( projectFilename );

		Path path;
		// REM TODO FIXME actually do something with Project object...
		printf ( "Found %d modules:\n", project->modules.size() );
		for ( size_t i = 0; i < project->modules.size(); i++ )
		{
			Module& m = *project->modules[i];
			printf ( "\t%s in folder: %s\n",
			         m.name.c_str(),
			         m.path.c_str() );
			printf ( "\txml dependencies:\n\t\t%s\n",
			         projectFilename.c_str() );
			const XMLElement* e = &m.node;
			while ( e )
			{
				if ( e->name == "xi:include" )
				{
					const XMLAttribute* att = e->GetAttribute("top_href",false);
					if ( att )
					{
						printf ( "\t\t%s\n", att->value.c_str() );
					}
				}
				e = e->parentElement;
			}
			printf ( "\tfiles:\n" );
			for ( size_t j = 0; j < m.files.size(); j++ )
			{
				printf ( "\t\t%s\n", m.files[j]->name.c_str() );
			}
		}
	
		delete project;

		return 0;
	}
	catch (Exception& ex)
	{
		printf ( "%s\n",
		         ex.Message.c_str() );
		return 1;
	}
}
